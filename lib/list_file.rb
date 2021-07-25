module ListMaker
  class ListFile
    
    @@filename = 'lm_list.txt'
    
    def initialize
      
      @filepath = File.join(APP_ROOT, @@filename)

      if File.exist?(@filepath)

        if !File.readable?(@filepath)
            abort('File exists but is not readable')
        elsif !File.writable?(@filepath)
            abort('File exists but is not writeable')
        end
        
      else 

        File.open(@filepath, 'w')

        if !File.exist?(@filepath)
            abort('File does not exist and cannot be created')
        end

      end
      
      self
      
    end
    
    def view
      puts "\nView List\n\n".upcase
      file = File.new(@filepath, 'r')
      file.each_line.with_index do |line, index|
        puts (index + 1).to_s + ". " + line.chomp 
      end
    end
    
    def add(args=[])
      puts "\nAdd a List Item\n\n".upcase
      if !args.empty?
        new_list_item = args.join(' ') 
      else
        puts "Enter new item to add to list:"
        new_list_item = gets.chomp 
      end
      File.open(@filepath, 'a') do |file|
        file << new_list_item
        file << "\n"
      end
    end
    
    def edit(args=[])
      puts "\nEdit a List Item\n\n".upcase

      if args.empty?
        puts "which item number would you like to edit?"
        position = gets.chomp.to_i
      else

      position = args.first.to_i

      end
      
      lines = File.readlines(@filepath)

      if lines.length < position 
        puts "item not found"
        return
      end

      puts "You are about to edit #{position}. #{lines[position - 1].chomp}"
      puts "Enter text to replace item or type 'done'"

      updated = gets
      if updated.chomp == 'done'
        return
      else

      lines[position - 1] = updated

      new_data = lines.join('')

      file = File.write(@filepath, new_data)

      end

    end

    def delete(args=[])
      puts "\nEdit a List Item\n\n".upcase

      if args.empty?
        puts "which item number would you like to delete?"
        position = gets.chomp.to_i
      else

      position = args.first.to_i

      end
      
      lines = File.readlines(@filepath)

      if lines.length < position 
        puts "item not found"
        return
      end

      puts "You are about to delete #{position}. #{lines[position - 1].chomp}"
      puts "Enter 'Y' to confirm or 'N' to terminate request:"

      answer = gets
      if answer.chomp.upcase == 'N'
        return
      elsif answer.chomp.upcase == 'Y'

      lines.delete_at(position - 1)

      new_data = lines.join('')

      file = File.write(@filepath, new_data)

      end

    end
    
  end
end
