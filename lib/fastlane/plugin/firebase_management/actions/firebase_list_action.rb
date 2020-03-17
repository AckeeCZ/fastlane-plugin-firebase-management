module Fastlane
	module Actions
		class FirebaseManagementListAction < Action

			def self.run(params)
				manager = FirebaseManagement::Manager.new

				# login
				api = nil
				type = nil
				bundle_id = nil
				if params[:service_account_json_path] != nil then
					api = manager.serviceAccountLogin(params[:service_account_json_path])
				elsif params[:email] != nil && params[:client_secret_json_path] != nil then
					api = manager.userLogin(params[:email], params[:client_secret_json_path])
				else
					UI.error "You must define service_account_json_path or email with client_secret_json_path."
					return nil
				end

				if params[:type] != nil then
					type = params[:type]
				end

				if params[:bundle_id] != nil then
					bundle_id = params[:bundle_id]
				end

				# download list of projects
				projects = api.project_list()
	
				# create formatted output
				bundle_id_array = []
				app_id_array = []
				projects.each_with_index { |p, i| 
					# UI.message "#{i+1}. #{p["displayName"]} (#{p["projectId"]})" 
					
					if type == "ios" then
						ios_apps = api.ios_app_list(p["projectId"])
						if !ios_apps.empty? then
							UI.message "  iOS"
							# UI.message bundle_id
							ios_apps.sort {|left, right| left["appId"] <=> right["appId"] }.each_with_index { |app, j|
								bundle_id_array.push(app["packageName"])
								app_id_array.push(app["appId"])
					
								if type == "ios" && bundle_id == app["packageName"] then
									return Hash[app["packageName"], app["appId"]]
								end
							}

							return Hash[bundle_id_array.zip(app_id_array)]
						end
					end

					if type == "android"
						android_apps = api.android_app_list(p["projectId"])
						if !android_apps.empty? then
							UI.message "  Android"
				
							android_apps.sort {|left, right| left["appId"] <=> right["appId"] }.each_with_index { |app, j|
								bundle_id_array.push(app["packageName"])
								app_id_array.push(app["appId"])
					
								if type == "android" && bundle_id == app["packageName"] then
									return Hash[bundle_id, app["appId"]]
								end
							}

							return Hash[bundle_id_array.zip(app_id_array)]
						end

					end
				}

				return nil
			end

			def self.description
				"List all Firebase projects and their apps"
			end

			def self.authors
				["Ackee, s.r.o."]
			end

			def self.return_value
				# If your method provides a return value, you can describe here what it does
			end

			def self.details
				# Optional:
				"Firebase plugin helps you list your projects, create applications and download configuration files."
			end

			def self.available_options
				[
					FastlaneCore::ConfigItem.new(key: :email,
											env_name: "FIREBASE_EMAIL",
										 description: "User's email to identify stored credentials",
											optional: true),

					FastlaneCore::ConfigItem.new(key: :client_secret_json_path,
											env_name: "FIREBASE_CLIENT_SECRET_JSON_PATH",
										 description: "Path to client secret json file",
											optional: true),

					FastlaneCore::ConfigItem.new(key: :service_account_json_path,
											env_name: "FIREBASE_SERVICE_ACCOUNT_JSON_PATH",
										 description: "Path to service account json key",
											optional: true
					),
					FastlaneCore::ConfigItem.new(key: :type,
											env_name: "TYPE",
											description: "Type of platform android or ios",
											optional: false
					),
					FastlaneCore::ConfigItem.new(key: :bundle_id,
											env_name: "BUNDLE_ID",
											description: "The bundle id of the specific app to return",
											optional: true
					)
				]
			end

			def self.is_supported?(platform)
				# Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
				# See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
				#
				# [:ios, :mac, :android].include?(platform)
				true
			end
		end
	end
end
