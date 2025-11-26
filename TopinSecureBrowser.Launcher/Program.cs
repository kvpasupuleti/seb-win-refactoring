using System;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;

namespace TopinSecureBrowser.Launcher
{
    class Program
    {
        [STAThread]
        static void Main(string[] args)
        {
            try
            {
                // Get the directory where TSB.exe is located
                string launcherDir = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
                
                // Try to find TopinSecureBrowser.exe in multiple locations
                string sebExecutable = FindTopinSecureBrowserExecutable(launcherDir);
                
                if (sebExecutable == null)
                {
                    MessageBox.Show(
                        "Topin Secure Browser executable not found.\n\n" +
                        "Searched locations:\n" +
                        "1. Same directory as TSB.exe\n" +
                        "2. ../Application/ (installer layout)\n" +
                        "3. SafeExamBrowser.Runtime\\bin\\x64\\Release\\ (dev build)\n\n" +
                        "Please ensure TopinSecureBrowser.exe is properly installed.",
                        "Topin Secure Browser - Error",
                        MessageBoxButtons.OK,
                        MessageBoxIcon.Error);
                    return;
                }

                // Create default configuration if needed
                string configPath = CreateDefaultConfig(launcherDir);

                // Prepare arguments for SEB
                string sebArgs = "";
                if (args.Length > 0)
                {
                    // Pass through any command line arguments
                    sebArgs = string.Join(" ", args);
                }
                else if (!string.IsNullOrEmpty(configPath))
                {
                    // Use default config if no arguments provided
                    sebArgs = $"\"{configPath}\"";
                }

                // Set working directory to where TopinSecureBrowser.exe is located
                string workingDir = Path.GetDirectoryName(sebExecutable);

                // Launch the Topin Secure Browser
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = sebExecutable,
                    Arguments = sebArgs,
                    UseShellExecute = false,
                    WorkingDirectory = workingDir
                };

                Process.Start(startInfo);
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Failed to launch Topin Secure Browser:\n\n{ex.Message}",
                    "Topin Secure Browser - Error",
                    MessageBoxButtons.OK,
                    MessageBoxIcon.Error);
            }
        }

        /// <summary>
        /// Searches for TopinSecureBrowser.exe in multiple locations
        /// </summary>
        private static string FindTopinSecureBrowserExecutable(string launcherDir)
        {
            // List of paths to search (in order of priority)
            string[] searchPaths = new[]
            {
                // 1. Same directory as TSB.exe (portable installation)
                Path.Combine(launcherDir, "TopinSecureBrowser.exe"),
                
                // 2. ../Application/ directory (standard installer layout)
                Path.Combine(launcherDir, "..", "Application", "TopinSecureBrowser.exe"),
                
                // 3. Parent directory (alternative layout)
                Path.Combine(launcherDir, "..", "TopinSecureBrowser.exe"),
                
                // 4. Development build location (relative to launcher output)
                Path.Combine(launcherDir, "..", "..", "..", "..", "SafeExamBrowser.Runtime", "bin", "x64", "Release", "TopinSecureBrowser.exe"),
                
                // 5. Common installation directory
                Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ProgramFiles), "TopinSecureBrowser", "Application", "TopinSecureBrowser.exe")
            };

            foreach (string path in searchPaths)
            {
                try
                {
                    string fullPath = Path.GetFullPath(path);
                    if (File.Exists(fullPath))
                    {
                        return fullPath;
                    }
                }
                catch
                {
                    // Ignore invalid paths and continue searching
                }
            }

            return null; // Not found
        }

        private static string CreateDefaultConfig(string directory)
        {
            string configPath = Path.Combine(directory, "topin-default.seb");
            
            // Only create if it doesn't exist
            if (!File.Exists(configPath))
            {
                try
                {
                    // Create a basic SEB configuration
                    // This is a minimal configuration that enables secure browsing
                    string defaultConfig = @"<?xml version=""1.0"" encoding=""UTF-8""?>
<!DOCTYPE plist PUBLIC ""-//Apple//DTD PLIST 1.0//EN"" ""http://www.apple.com/DTDs/PropertyList-1.0.dtd"">
<plist version=""1.0"">
<dict>
    <key>allowBrowsingBackForward</key>
    <true/>
    <key>allowReloading</key>
    <true/>
    <key>allowSpellCheck</key>
    <false/>
    <key>allowUserAppFolderInstall</key>
    <false/>
    <key>browserMessagingSocket</key>
    <string>ws://localhost:8706</string>
    <key>browserUserAgent</key>
    <string>SEB</string>
    <key>enableBrowserWindowToolbar</key>
    <true/>
    <key>enableJavaScript</key>
    <true/>
    <key>enablePlugIns</key>
    <false/>
    <key>examKeySalt</key>
    <data>WU9VUl9TQUxUX0hFUkU=</data>
    <key>hashedQuitPassword</key>
    <string></string>
    <key>killExplorerShell</key>
    <false/>
    <key>newBrowserWindowByLinkPolicy</key>
    <integer>2</integer>
    <key>showMenuBar</key>
    <false/>
    <key>showTaskBar</key>
    <false/>
    <key>startURL</key>
    <string>https://www.topin.tech</string>
    <key>touchOptimized</key>
    <false/>
    <key>urlFilterEnable</key>
    <false/>
</dict>
</plist>";

                    File.WriteAllText(configPath, defaultConfig);
                }
                catch
                {
                    // If we can't create the config, that's okay - SEB will use defaults
                    return null;
                }
            }
            
            return configPath;
        }
    }
}
