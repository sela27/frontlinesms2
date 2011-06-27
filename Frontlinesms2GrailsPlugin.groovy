class Frontlinesms2GrailsPlugin {
    def version = "0.1-SNAPSHOT"
    def grailsVersion = "1.3.7 > *"
    def dependsOn = ["csv":"0.3","jquery":"1.6.1.1","routing":"1.1.0"]
    def pluginExcludes = ["grails-app/views/error.gsp"]
    def author = "FrontlineSMS team"
    def authorEmail = "dev@frontlinesms.com"
    def title = "FrontlineSMS Core"
    def description = ""
    def documentation = "https://github.com/frontlinesms/frontlinesms2"
}
