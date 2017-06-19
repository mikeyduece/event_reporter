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
    long_third_command(commands)
    @first_command = commands[0] if commands[0] != nil
    @second_command = commands[1] if commands[1] != nil
    @third_command = commands[2] if commands[2] != nil
  end

  def long_third_command(commands)
    if commands.count > 3
      comm = commands[2..3].join('_')
      commands.slice!(2..3)
      commands << comm
    end
  end

  def second_entry(commands)
    if commands[2] == "by" || commands[2] == "to"
      att = commands[1..2].join('_')
      commands.slice!(1..2)
      commands.insert(1,att)
    end
  end

end
