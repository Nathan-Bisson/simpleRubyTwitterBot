require 'jumpstart_auth'

$time_count = 1
$array_count = 0
$tweet_array = []

class TwitterBot
    attr_reader :client
    
    def initialize
        @client = JumpstartAuth.twitter
        puts "Bot initialized\n\n"
        
        botSetUp
    end
    
    def botSetUp
        command = ""
        
        while command != "quit" && command != "finish"
            print("\nEnter The Tweets You Wish To Send Out Then Type 'finish' When Done Or 'quit' => To Exit: ")
            command = gets.chomp
            
            case command
            when 'finish'
                setTimeDelay
            when 'quit'
                puts "Bot Exit"
             else 
                if command.length <= 140
                    $tweet_array << command
                else 
                    puts "\nYOUR TWEET MUST BE UNDER 140 CHARACTERS!\n"
                end    
            end    
        end     
    end  
    
    def setTimeDelay
        time_delay = ""
        is_integer = false
        
        while is_integer == false
            print("\nEnter The Time In SECONDS For The Delay Between Each Tweet: ")
            time_delay_string = gets.chomp
            time_delay = time_delay_string.to_i
            
            if time_delay == 0
                puts "\nPlease enter an integer\n"
            else 
                tweetSendOutTimer(time_delay)
                is_integer = true
            end    
       end    
    end
    
    def tweetSendOutTimer(time_delay)
        while $time_count <= $tweet_array.length
            puts "TWEET SENT OUT"
            tweet($tweet_array[$array_count])
            $time_count += 1
            $array_count += 1
            sleep time_delay 
        end  
    end    
    
    def tweet(message)
        if message.length <= 140
            @client.update(message)
        else 
            puts "This Message is too long!"
        end    
    end    
end  

blogger = TwitterBot.new