# firebase_management `fastlane` Plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-firebase_management)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-firebase_management`, add it to your project by running:

```bash
fastlane add_plugin firebase_management
```

## About firebase_management

An unofficial tool to access Firebase project settings. It allows you to create new apps and download config files (GoogleInfo.plist for ios and google-services.json for android).

Plugin uses new official [Firebase Management API](https://firebase.google.com/docs/projects/api/reference/rest/) introduced on Firebase Summit 10/2018. It's based on [ackeeCZ/fastlane-firebase-plugin](https://github.com/ackeeCZ/fastlane-firebase-plugin), which uses web scraping instead of official API to manage Firebase apps. The plan is that both plugins will live next to each other until official API will contain all desired features and tkohout's plugin won't be needed anymore.

New features like deleting apps or APNs keys/certificates management are promised by guys from Google/Firebase so stay tuned 🤙

**This very first version was developed using alpha version of the API in a very short time, so it may contain bugs or mistakes. Issues and PRs are very welcome! This was forked from a fork to add more versatility to the firebase_management_list action. 🤗**

### Actions

List all projects and apps. If you leave this action blank it will prompt for the required fields

```
firebase_management_list
```

Better example:

```
firebase_list = firebase_management_list(
    service_account_json_path:  "firebase_project_name.json",
    type: "android" #(Required). Android or ios This field will return a hash of bundle id's and their firebase app id's
    bundle_id: bundle_id, # This is the bundle id of the app you are searching for. If left blank all app ids will return
)

```

Where the value of `firebase_list` would be 

```
{com.captainjeff.com: 1:123456789:android:abcd1234}
```

Add app to a project and download config file

```
firebase_management_add_app
```

Download config file for a client

```
firebase_management_download_config
```

Better example:

```
firebase_management_download_config(
          service_account_json_path: "firebase_project_name.json",
          type: "android",
          app_id: firebase_list[application_id], #Use the response from the firebase_management_list function to know the app id
          output_path: "./app",
          project_id: project_id #Name of the project which is created on the firebase console. Each project can contain 20 or so apps for ios and android each
        )
```

### Authentication

~~Plugin works only with service accounts.~~

#### User login
You can use your ordinary account in combination with client secret json file created in GCP console.

#### Service accounts
A service account is a special Google account that belongs to your application or a virtual machine, instead of to an individual end user. Read more [here](https://cloud.google.com/iam/docs/service-accounts).

All you need for the plugin to work is a json file with service account private key information. The easiest way to get it is...

Go to Firebase Console -> Your project -> Project settings -> Service accounts and tap on button `Generate new private key`. 🎉 That's the file you need!

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.


## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

## Warning

DISCLAIMER OF WARRANTIES AND LIMITATION OF LIABILITY.

UNLESS OTHERWISE SEPARATELY UNDERTAKEN BY THE LICENSOR, TO THE EXTENT POSSIBLE, THE LICENSOR OFFERS THE LICENSED MATERIAL AS-IS AND AS-AVAILABLE, AND MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND CONCERNING THE LICENSED MATERIAL, WHETHER EXPRESS, IMPLIED, STATUTORY, OR OTHER. THIS INCLUDES, WITHOUT LIMITATION, WARRANTIES OF TITLE, MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, ABSENCE OF LATENT OR OTHER DEFECTS, ACCURACY, OR THE PRESENCE OR ABSENCE OF ERRORS, WHETHER OR NOT KNOWN OR DISCOVERABLE. WHERE DISCLAIMERS OF WARRANTIES ARE NOT ALLOWED IN FULL OR IN PART, THIS DISCLAIMER MAY NOT APPLY TO YOU.

TO THE EXTENT POSSIBLE, IN NO EVENT WILL THE LICENSOR BE LIABLE TO YOU ON ANY LEGAL THEORY (INCLUDING, WITHOUT LIMITATION, NEGLIGENCE) OR OTHERWISE FOR ANY DIRECT, SPECIAL, INDIRECT, INCIDENTAL, CONSEQUENTIAL, PUNITIVE, EXEMPLARY, OR OTHER LOSSES, COSTS, EXPENSES, OR DAMAGES ARISING OUT OF THIS PUBLIC LICENSE OR USE OF THE LICENSED MATERIAL, EVEN IF THE LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH LOSSES, COSTS, EXPENSES, OR DAMAGES. WHERE A LIMITATION OF LIABILITY IS NOT ALLOWED IN FULL OR IN PART, THIS LIMITATION MAY NOT APPLY TO YOU.

THE DISCLAIMER OF WARRANTIES AND LIMITATION OF LIABILITY PROVIDED ABOVE SHALL BE INTERPRETED IN A MANNER THAT, TO THE EXTENT POSSIBLE, MOST CLOSELY APPROXIMATES AN ABSOLUTE DISCLAIMER AND WAIVER OF ALL LIABILITY.
