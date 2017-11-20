class SocialProfile < ApplicationRecord
  belongs_to :user
  store :other
  validates_uniqueness_of :uid, scope: :provider

  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']
    credentials = omniauth['credentials']
    info = omniauth['info']

    self.access_token = credentials['token']
    self.access_secret = credentials['secret']
    self.credentials = credentials.to_json
    self.email = info['email']
    self.name = info['name']
    self.description = info['description'].try(:truncate, 255)
    case provider.to_s
    when 'linkedin'
      self.url = info['urls']['public_profile']
    when 'twitter'
      self.url = info['urls']['Twitter']
      self.other[:location] = info['location']
      self.other[:website] = info['urls']['Website']
    end

    self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    case provider.to_s
    when 'google'
      self.url = raw_info['link']
    when 'twitter'
      self.other[:followers_count] = raw_info['followers_count']
      self.other[:friends_count] = raw_info['friends_count']
      self.other[:statuses_count] = raw_info['statuses_count']
    end

    self.raw_info = raw_info.to_json
    self.save!
  end
end
