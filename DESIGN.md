# TemplateCli Design

##1. Entries of templatecli
Introduction of the usage

###1.1 templatecli init name version
As a template provider, you init a code template project, which specify the name and version.

Design
Using Template::Project.init to create ./template.prj.

###1.2 templatecli publish
As a template provider, you should publish it to template center for consume.
* Before publish, check if local template center or remote template center exists by `templatecli info`

Design
Using Template::Publish to publish current template project
	- using "Template::LocalPublish < Publish" publish to local template center if no remote template center defined.
	- using "Template::RemotePublish < Publish" publish to remote template center if remote template center defined.

###1.3 templatecli init as center
In version 1.0.x
As a template consumer, you should point a path as the template center of local file-system.

Design
Using Template::Center.init to create ~/.template-center file, which shared in templatecli runtime.
Using Template::Center.cache to create ./.template-center file, and point current path as the path of local template center.

###1.6 templatecli init as center from http://10.0.0.2/template-center
In version 2.0.x
As a template consumer, you could define a remote template center urls.

Design
Using Template::Center.init to create ~/.template-center file, add default url to address remote template-center.
Using Template::Center.init to create ~/.template-center file, add url to address remote template-center.

###1.4 templatecli use name version
As a template consumer, you could use a template within specific version from the local template center.

Design
Using Template::Migration.migrate to start migrate tasks base on template_project/template.prj and ./templates.prj
Using "Template::MigrateCopy < Migrate" to copy required folder and files.
Using "Template::MigrateGradleDependency < Migrate" to add gradle dependencies.
Using "Template::MigrateMavenDependency < Migrate" to add maven dependencies.

For extensions, you could publish a external sub-class of Template::Migrate to define the specific migrate task. 
And add the extensions in template_project/template.prj

###1.5 templatecli info
As a template user, you could check the information of current templatecli.
- name
- version
- local template center
- remote template center

Design
Using Template::Info to show the information about current templatecli.

###1.6 templatecli uses
As a template consumer, you could check whats the template used:
- name, version, update date, from, authors

Design
Using Template:UsesInfo to show the templates depend on.

##2. PrettyLog
Print logs in console in pretty format

Command: Init as a template project
	./template.prj created.
	./files created.
end.

Command: Init as a template project
	[Error] failed no arg of name
	[Error] failed no arg of version
end.

Command: Init as a template project
	Folder ./actions created.
		./actions/file1 created. (* define something here)
		./actions/file2 created. (* define something here)
	./files created.
end.

Design
Using PrettyLog::Log.share(string) for sharing the log instance between classes
Using PrettyLog::Log.share(string).add(msg, level=1) to record the message in print level
Using PrettyLog::Log.share(string).add_error(error_msg) to record the error message
Using PrettyLog::Log.share(string).print to print the logs to console.


