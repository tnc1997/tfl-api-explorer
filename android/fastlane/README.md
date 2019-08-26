fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## Android
### android deploy
```
fastlane android deploy
```
Deploys the current build to the Internal track
### android promote_internal
```
fastlane android promote_internal
```
Promotes the Internal track to the Alpha track
### android promote_alpha
```
fastlane android promote_alpha
```
Promotes the Alpha track to the Beta track
### android promote_beta
```
fastlane android promote_beta
```
Promotes the Beta track to the Production track

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
