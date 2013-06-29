module AwsHelper
  def getS3Bucket(path)
    captures = /[S,s]3:\/\/([^\s]+)\/([^\s]+)\ ([^\s]+)\ ([^\s]+)$/.match(path).captures

    connection = Fog::Storage.new(
      :provider => 'AWS',
      :aws_access_key_id => captures[2],
      :aws_secret_access_key => captures[3],
      :region => captures[0])

    bucket = captures[1]

    connection.directories.get(bucket)
  end

  def isS3Bucket?(path)
    /[s,S]3:\/\/.+$/.match(path) != nil
  end

  def getS3Url(path, libraryPath)
    matches = /[s,S]3:\/\/[^\/]+\/(.+)$/.match(path).captures
    file = matches[0]

    bucket = getS3Bucket(libraryPath)

    bucket.files.get_https_url(file, Time.new.utc.to_i() + 60 * 60)
  end
end