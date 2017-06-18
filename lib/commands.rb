class Commands

  attr_accessor :change_commands

  def initialize
    @first_command = ""
    @second_command = ""
    @third_command = ""
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
    long_entry(commands)
    @first_command = commands[0] if commands[0] != nil
    @second_command = commands[1] if commands[1] != nil
    @third_command = commands[2] if commands[2] != nil
  end

  def long_entry(commands)
    if commands.count > 3
      att = commands[1..2].join('_')
      commands.slice!(1..2)
      commands.insert(1,att)
    end
  end

end
