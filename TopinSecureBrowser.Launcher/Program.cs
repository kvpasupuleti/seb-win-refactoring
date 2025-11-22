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
                
                // Look for TopinSecureBrowser.exe in the same directory
                string sebExecutable = Path.Combine(launcherDir, "TopinSecureBrowser.exe");
                
                if (!File.Exists(sebExecutable))
                {
                    MessageBox.Show(
                        "Topin Secure Browser executable not found.\n\nPlease ensure TopinSecureBrowser.exe is in the same directory as TSB.exe.",
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

                // Launch the Topin Secure Browser
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = sebExecutable,
                    Arguments = sebArgs,
                    UseShellExecute = true,
                    WorkingDirectory = launcherDir
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
