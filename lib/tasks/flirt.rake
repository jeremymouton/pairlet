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
      puts flirt.handle
      #####
      # try to match each flirt to a user handle
      @match = Link.where(handle: flirt.handle, provider: flirt.provider).first
      unless @match.nil?
        # store it
        @matching_flirts << @match
        #####
        # find the users
        @matching_user = User.where(id: @match.user_id).first
        @flirting_user = User.where(id: flirt.user_id).first

        puts @matching_user.email + " (ID: #{@match.user_id.to_s}) flirted by #{@flirting_user.email}"
        puts '------'

        # Flag the flirt as matched with an existing user
        flirt.update_attribute(:matched, true)

        # Create the relationship
        # [TODO]: 
        # This will trip if 2 handles are processed for the flirter->flirted association
        # since it will already exists. 
        # The above ":matched" flag should also prevent the error from tripping the script
        @flirting_user.follow!(@matching_user)
      end
    end

    if @matching_flirts.empty?
      puts "*** no matched flirts ***"
    end

    # Print the results
    puts "-----------"
    print "#{@flirts.count} flirts processed, with #{@matching_flirts.count} matches discovered."
    
    ## Print a heart for every matched handle
    if @matching_flirts.count > 0
      @matching_flirts.each do
        print <<-EOF

          ,d88b.d88b,
          88888888888 
          `Y8888888Y'
            `Y888Y'
              `Y'

        EOF
      end
    else
      puts ' :(' 
    end
  end

end