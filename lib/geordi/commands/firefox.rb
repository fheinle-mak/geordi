desc 'firefox COMMAND', 'Run a command with firefox for selenium set up (alias: chrome)'
long_desc <<-LONGDESC
Example: `geordi firefox b cucumber` or `geordi firefox --setup 24.0`

Useful when you need Firefox for Selenium or the VNC set up, but can't use the
`geordi cucumber` command.

*Install* a special Firefox by calling with `--setup <version>`.

This command is aliased `chrome` for users running Selenium in Chrome.
LONGDESC

option :setup, :type => :string, :banner => 'setup=FIREFOX_VERSION',
  :desc => 'If set, will install a special Firefox with the given version'

def firefox(*command)
  if options.setup
    require 'geordi/firefox_for_selenium'
    Geordi::FirefoxForSelenium.install(options.setup)

  else
    require 'geordi/cucumber'

    Cucumber.new.setup_vnc
    FirefoxForSelenium.setup_firefox

    puts
    note_cmd command.join(' ')
    system *command # Util.system! would reset the Firefox PATH
  end
end

map 'chrome' => 'firefox'