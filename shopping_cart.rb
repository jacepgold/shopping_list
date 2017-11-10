# Jace P. Gold
# November 7th, 2017

# To Do
# Check to see if item exists in store to prevent an error when deleting and 'banana' is entered
# Check to see if item exits in list to prevent error when deleting and 'banana' is entered

@list = []
@store = [
    { name: 'apple', price: 1.00 },
    { name: 'spaghetti', price: 5.00 },
    { name: 'milk', price: 2.00 }
]


def add_item
    puts "\n\n\t------ Add An Item ------"
    
    if @store.empty?
        puts "\n\tNothing else to add to list."
        menu
    elsif @store.empty? == false
        view_list('store')
        puts "\n\tWhat would you add to your list?"
        puts "\tType \"back\" to go back."
        puts"\tType \"remove\" to remove an item."
        print '> '
        the_item = $stdin.gets.strip
        the_item.downcase
        puts the_item
        # check to see if item exists in store
        
        if the_item.empty? # Fallback incase the user does not enter an item
            view_list('list')
            view_list('store')
            puts "Please select an item."
            add_item
        elsif the_item.include?('back') || the_item.include?('done')
            menu # Back to the main menu
        elsif the_item.include?('remove')
            remove_item
        else
            the_item = @store.find { |location| location[:name] == the_item } # Access hash with key value item_name 
            @list.push(the_item) # Put the item in the list array
            @store.delete(the_item)
            get_total
        end
    else 
        puts "There has been a fatal error."
    end
end


def remove_item
    puts "\n\n\t------ Remove An Item ------"
    
    if @list.empty?
        puts "\n\tYour shopping list is empty."
        menu
    elsif @list.empty? == false
        view_list('list')
        puts "\n\tWhat would you remove from the list?"
        puts "\tType \"back\" to go back."
        puts"\tType \"add\" to add an item."
        print '> '
        the_item = $stdin.gets.strip
        the_item.downcase
        puts the_item
        if the_item.empty? # Fallback incase the user does not enter an item
            puts "Please select an item."
            add_item
        elsif the_item.include?('back') || the_item.include?('done')
            menu
        elsif the_item.include?('add')
            add_item
        else
            the_item = @list.find { |location| location[:name] == the_item } # Access hash with key value item_name 
            @store.push(the_item) # Put the item in the list array
            @list.delete(the_item)
            puts "Your new total is #{get_total}.\n\n"
        end
    else 
        puts "There has been a fatal error."
    end
end


def get_total
    total_cost = 0
    @list.each do |key|
        total_cost += key[:price]
    end

    total_cost = '%.2f' % total_cost # Give us two decimal points always
   # puts "\n\tTotal Cost is $#{total_cost}."
end


def view_list(which_list)
    if which_list == 'list'
        if @list.any?
            puts "\n\tYour list has "
            @list.each_with_index do |item, i|
                puts "- #{item[:name]}"
            puts get_total
            end
        else
            puts "You currently do not have any items on your shopping list.\n"
        end
    elsif which_list == 'store'
        if @store.any?
            puts "\n\tThe Store Has"
            @store.each_with_index do |item, i|
                puts "- #{item[:name]}"
            end
        else
            puts "There's nothing left to add."
        end
    else
        puts "Bad user input"
    end
end


def menu
    puts "\n\n\t------  Menu  ------"
    view_list('list')

    puts "\n1.) Type \"add\" to view available items."
    puts '2.) Type "remove" to remove items from your list. '
    puts '3.) Type "Done" to finish.'
    puts "\n"
    print "> "
    choice = $stdin.gets.strip.downcase

    listening = true
    while listening
        if choice.include?('add') || choice == '1'
            add_item
        elsif choice.include?('remove') || choice.include?('return') || choice == '2'
            remove_item
        elsif choice.include?('done') || choice.include?('done') || choice == '3'
            #Clear the screen when the program is done to not freak the user out with a messy prompt
            system('clear')
            exit 0
        else
            puts "Invalid user input. Please try again.\n\n"
            menu
        end
    end
    menu
end

menu