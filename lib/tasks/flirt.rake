# ---------------------------
#
# Rakefile for Flirt project
# Author: Jeremy Mouton
#
# ---------------------------

namespace :flirt do

  desc "Run it all"
  task :all => [:welcome, :find_handles]

  task :welcome do
    puts "This rake task finds all flirted handles and set a Flirter->Flirted relationship if the flirt handle matches a user's handle (in the Links table)."
  end

  # -----
  # In this Rake task, we want to gather all the "Flirts" that have umatched user handles 
  # and compare them to the user's links table -- (where users define their social accounts: 
  # provider|handle pair)
  # 
  # If a match occurs, a relationship is set using @matching_user as flirted_id
  # and printa heart. 
  #

  desc "Find all flirted handles and set relationships"

  task :find_handles => :environment do
    
    @flirts = Flirt.where(matched: false)
    @matching_flirts = Array.new

    @flirts.each do |flirt|

      # try to match each flirt to a user handle
      @match = Link.where(handle: flirt.handle, provider: flirt.provider).first
      
      unless @match.nil?
        # store it
        @matching_flirts << @match

        # find the users
        @matching_user = User.where(id: @match.user_id).first
        @flirting_user = User.where(id: flirt.user_id).first

        # Flag the flirt as matched with an existing user
        flirt.update_attribute(:matched, true)

        # Create the relationship
        @flirting_user.follow!(@matching_user)

        # Check for a mutual connection
        if @flirting_user.mutual_flirts?(@matching_user)
          @connections = Array.new
          @connections << @matching_user
         
          UserMailer.connection_email(@flirting_user, @matching_user).deliver
          UserMailer.connection_email(@matching_user, @flirting_user).deliver
        end

      end
    end
  end

end