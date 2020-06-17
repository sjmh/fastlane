require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppStoreVersion
      include Spaceship::ConnectAPI::Model

      attr_accessor :platform
      attr_accessor :version_string
      attr_accessor :app_store_state
      attr_accessor :store_icon
      attr_accessor :watch_store_icon
      attr_accessor :copyright
      attr_accessor :release_type
      attr_accessor :earliest_release_date # 2020-06-17T12:00:00-07:00
      attr_accessor :uses_idfa
      attr_accessor :is_watch_only
      attr_accessor :downloadable
      attr_accessor :created_date

      module AppStoreState
        READY_FOR_SALE = "READY_FOR_SALE"
        PREPARE_FOR_SUBMISSION = "PREPARE_FOR_SUBMISSION"
      end
      
      module ReleaseType
        AFTER_APPROVAL = "AFTER_APPROVAL"
        MANUAL = "MANUAL"
        SCHEDULED = "SCHEDULED"
      end

      attr_mapping({
        "platform" =>  "platform",
        "versionString" =>  "version_string",
        "appStoreState" =>  "app_store_state",
        "storeIcon" =>  "store_icon",
        "watchStoreIcon" =>  "watch_store_icon",
        "copyright" =>  "copyright",
        "releaseType" =>  "release_type",
        "earliestReleaseDate" =>  "earliest_release_date",
        "usesIdfa" =>  "uses_idfa",
        "isWatchOnly" =>  "is_watch_only",
        "downloadable" =>  "downloadable",
        "createdDate" =>  "created_date"
      })

      def self.type
        return "appStoreVersions"
      end

      #
      # API
      #

      # app,routingAppCoverage,resetRatingsRequest,appStoreVersionSubmission,appStoreVersionPhasedRelease,ageRatingDeclaration,appStoreReviewDetail,idfaDeclaration,gameCenterConfiguration
      def self.get(app_store_version_id: nil, includes: nil, limit: nil, sort: nil)
        return Spaceship::ConnectAPI.get_app_store_version(
            app_store_version_id: app_store_version_id, 
            includes: includes
        ).first
      end

      def update(attributes: nil)
        Spaceship::ConnectAPI::patch_app_store_version(app_store_version_id: id, attributes: attributes)
      end

      #
      # App Store Version Localizations
      #

      def create_app_store_version_localization(attributes: nil)
        resp = Spaceship::ConnectAPI.post_app_store_version_localization(app_store_version_id: id, attributes: attributes)
        return resp.to_models.first
      end

      # appScreenshotSets,appPreviewSets
      def get_app_store_version_localizations(filter: {}, includes: "appScreenshotSets", limit: nil, sort: nil)
        filter ||= {}
        filter["appStoreVersion"] = id
        return Spaceship::ConnectAPI::AppStoreVersionLocalization.all(filter: filter, includes: includes, limit: limit, sort: sort)
      end

      #
      # App Store Review Detail
      #

      def get_app_store_review_detail
        resp = Spaceship::ConnectAPI.get_app_store_review_detail(app_store_version_id: id)
        return resp.to_models.first
      end

      #
      # App Store Version Phased Releases
      #

      def get_app_store_version_phased_release
        resp = Spaceship::ConnectAPI.get_app_store_version_phased_release(app_store_version_id: id)
        return resp.to_models.first
      end

      def create_app_store_version_phased_release(attributes: nil)
        resp = Spaceship::ConnectAPI.post_app_store_version_phased_release(app_store_version_id: id, attributes: attributes)
        return resp.to_models.first
      end

      #
      # Reset Ratings Requests
      #

      def get_reset_ratings_request
        resp = Spaceship::ConnectAPI.get_reset_ratings_request(app_store_version_id: id)
        return resp.to_models.first
      end

      def create_reset_ratings_request
        resp = Spaceship::ConnectAPI.post_reset_ratings_request(app_store_version_id: id)
        return resp.to_models.first
      end
    end
  end
end
