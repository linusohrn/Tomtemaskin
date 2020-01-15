bla = 0
while bla <= 19999
    starttime = Time.now
    10000.times do 
        bla += 1
        if bla <= 10000
            puts "http://www.oddschecker.com/american-football/cfl/hamilton-tigercats-at-winnipeg-blue-bombers/winner%3E"
        end
        sleep(0.03)
    end
    deltatime = Time.now - starttime
    puts deltatime
end

puts bla