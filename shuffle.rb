require 'mail'

emails = 
  ["micinski@cs.umd.edu", "krismicinski@gmail.com"]
  # ["dvanhorn@cs.umd.edu",
  #  "amiller@cs.umd.edu",
  #  "micinski@cs.umd.edu",
  #  "jp@jamesparker.me",
  #  "mwh@cs.umd.edu"]

class SecretSantaEmailer
  attr_reader :santa
  attr_writer :santa
  
  def new(people)
    @people = people
    @sana = "santa@northpo.le"
  end
  
  # Make an anamorphism M from l -> l such that there is no x in l for
  # which M(x) = x.  (So nobody gives a gift to themselves)
  def makebijection(lst)
    l = lst.shuffle
    l.length.times { |x|
      if (lst[x] == l[x]) then
        return makebijection(lst)
      end
    }
    l
  end
  
  # Shuffle a list of 
  def shuffle!
    @bijection = @people.zip(makebijection(@people))
  end
  
  # Send the list of people to peopl
  def send_assignments
    @bijection.each { |x|
      mail = Mail.new do
        to x[0]
        from @santa
        subject 'You\'ve got a secret santa!'
        body "Hey there!\nYou are a secret santa for: #{x[1]}\n\nMake them feel special!\n\n--Santa"
      end
      mail.delivery_method :sendmail
      mail.deliver!
    }
  end
end

SecretSantaEmailer.new(emails).shuffle!.send_assignments
