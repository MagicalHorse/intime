class VersionController < ApplicationController
  def latest
    version_in = params[:client_version]
    return render :json=> error_500 {'version param is empty!'} if version_in.nil?
    version_int = Version.version_fromstring(version_in.to_s)
    latest_version = Version.where('no>? and status=?',version_int,1).order('no desc').first
    return render :json=>succ_compose_200 {|h|
      h[:data]={
        :title=> t(:vc_islatest),
        :type=> 0
      }} if latest_version.nil?
    title = t(:vc_newupdatemsg) unless latest_version.nil?
    return render :json=>succ_compose_200 {|h|
      h[:data]= {
        :title=> title,
        :versionno=>latest_version.versionno,
        :desc=>latest_version.desc,
        :downloadurl=>latest_version.downloadurl,
        :type=>latest_version.updatetype,
        :startimage=> '',   
        :startimage_iphone5 =>''
      }
    }
  end
  
end
