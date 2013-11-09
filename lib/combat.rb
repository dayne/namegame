
class Combat
  # This needs some rework its gotten fat and clumsy, but it works...
  # I should include a transcript of the combat to be saved to a text file just for fun

  def initialize( heroes, fallen, boolSpar )
    combat(fallen, boolSpar )
    @heroes = heroes
  end

  def combat(fallen, boolSpar )
    @spar = boolSpar
    @range = @heroes.length
    if @range <= 1
      puts 'There are not enough available combatants'
    else
      puts '<<The Heroes>>'
      lineup(@heroes)
      puts ''
      valid_choice = false
#---attempt to parse an input and use it as the choice
      while (not valid_choice)
        puts 'First combatant'
        c1 = gets.chomp.to_i - 1
#---	@good = false
#---	@heroes.each.first.any? { |w| c1 =~ /#{w}/  }
        puts 'Second combatant'
        c2 = gets.chomp.to_i - 1
	c2 = gets.chomp
        if c2 == c1
    puts @heroes[c1].show_name + ' cannot fight themselves! Choose again.'
	else
	  valid_choice = true
	end
      end

      #need to think of a better health system, but I want multiple hits to win for now...      
      @c1health = @heroes[c1].get_level + 1
      @c2health = @heroes[c2].get_level + 1

      puts 'Let the battle begin!'
      puts ''
      victory = false
      while (not victory)
	@c1a = attack( @heroes[c1] )
	@c2a = attack( @heroes[c2] )
	print '(' + @c1a.to_s + 'x' + @c2a.to_s + ')'

        #need to read more on comparable module, might make a lot more sense to use it here
	#should I define the % ranges as verious levels of hits and/or misses i.e. 0-25 misses etc, 		perhaps even defining criticals as compared, if high enough blocking/parrying happens...

	if @c1a == @c2a
	  puts 'It\'s that moment in a fight when they bring their weapons together and glare at one another face to face'
	elsif @c1a > @c2a
	  @c2health -= 1
	  puts @heroes[c1].first_name + ' wounds ' + @heroes[c2].first_name
	  if @c2health < 0
            puts ''
	    puts @heroes[c1].show_name + ' strikes down ' + @heroes[c2].show_name
	    if @spar == false
	      puts 'Give \'' + @heroes[c1].show_name + '\' an addtion to his name'
	      input = gets.chomp
	      @heroes[c1].add_name(input)
	      fallen.push(@heroes[c2])
	      @heroes.delete_at(c2)
	    end
	    victory = true
	  end
	elsif @c1a < @c2a
	  @c1health -= 1
	  puts @heroes[c2].first_name + ' wounds ' + @heroes[c1].first_name
	  if @c1health < 0
            puts ''
	    puts @heroes[c2].show_name + ' strikes down ' + @heroes[c1].show_name
	    if @spar == false
	      puts 'Give \'' + @heroes[c2].show_name + '\' an addtion to his name'
	      input = gets.chomp
	      @heroes[c2].add_name(input)
	      fallen.push(@heroes[c1])
	      @heroes.delete_at(c1)
	    end
	    victory = true
	  end
	end
      end
    end
  end

  def attack( aHero )
    @hero = aHero
    @result = Die.new.roll + (@hero.get_level * 2)
    return @result
  end

  #kill(or retire method, can double duty it...) method maybe to clean up the combat section a bit...

end
