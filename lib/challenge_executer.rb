# frozen_string_literal: true

require_relative 'url_follower'

# Main entry point for executing challenges using URL following.
class ChallengeExecutor
  def self.start(path)
    UrlFollower.follow_challenge(path)
  end
end

ChallengeExecutor.start('/challenge.json')
