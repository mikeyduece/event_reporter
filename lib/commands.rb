class Commands

  attr_accessor :change_commands

  def initialize
    @first_command  = ""
    @second_command = ""
    @third_command  = ""
  end

  def first_command
    @first_command
  end

  def second_command
    @second_command
  end

  def third_command
    @third_command
  end

  def change_commands(command)
    commands = command.split
    second_entry(commands)
    long_third_command(commands,commands[1])
    @first_command = commands[0] if commands[0] != nil
    @second_command = commands[1] if commands[1] != nil
    @third_command = commands[2] if commands[2] != nil
  end

  def long_third_command(commands,filter = "")
    last_element = commands.length - 1
    if commands.length > 3
      criteria = commands.index(filter) + 1
      commands[criteria] = commands[criteria..last_element].inject do |result, command|
        result += " #{command}"
      end
      commands.pop(last_element-criteria)
    end
  end

  def second_entry(commands)
    if commands[2] == "by" || commands[2] == "to" || commands[2] == "name"
      att = commands[1..2].join('_')
      commands.slice!(1..2)
      commands.insert(1,att)
    end
  end

end
