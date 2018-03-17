[![badge][ci]][circle]

_[Homebrew]_ Adobe
==================
Homebrew _[tap]_ for [Adobe] apps, and even [plugins]!

Install
-------
~~~ sh
brew tap danielbayley/adobe
brew cask install #cask
brew install #formula
~~~

[Some] [_Cask_]s rely on an [environment variable] to function, which can be set in your [shell startup file], for example: `export HOMEBREW_ADOBE_CASK=value >> ~/.bashrc`. Further information will be displayed as [`caveats`], which are always available by running `brew info cask`.

[Contribute][guide]
-------------------
`git config core.hooksPath hooks` and follow the contribution [guide], or copy and adapt an [existing] cask.

License
-------
[MIT] © [Daniel Bayley]

[MIT]:                    LICENSE.md
[Daniel Bayley]:          https://github.com/danielbayley

[ci]:                     https://img.shields.io/circleci/project/danielbayley/homebrew-adobe.svg?style=flat-square
[circle]:                 https://circleci.com/gh/danielbayley/homebrew-adobe

[adobe]:                  https://adobe.com
[plugins]:                https://exchange.adobe.com/addons

[homebrew]:               http://brew.sh
[tap]:                    https://docs.brew.sh/Taps
[_cask_]:                 http://caskroom.github.io

[guide]:                  https://github.com/caskroom/homebrew-cask/blob/master/doc/development/adding_a_cask.md
[existing]:               Casks
[some]:                   https://github.com/danielbayley/homebrew-adobe/blob/master/Casks/rubberhose.rb#L20-L21
[`caveats`]:              https://github.com/caskroom/homebrew-cask/blob/master/doc/cask_language_reference/stanzas/caveats.md#caveats

[environment variable]:   https://en.wikipedia.org/wiki/environment_variable
[shell startup file]:     https://en.wikipedia.org/wiki/Unix_shell#Configuration_files
