require 'terminal-table'

module ShowContent
  DIFFICULTY = {
    easy: { attempts: 15, hints: 2 },
    medium: { attempts: 10, hints: 1 },
    hell: { attempts: 5, hints: 1 }
  }.freeze

  def show_stats(file)
    data = YAML.load_file(file) || []
    data.sort_by(&:hints_used).sort_by(&:attempts_used).sort_by { |game| -game.difficulty }
    create_table(data)
  rescue Errno::ENOENT
    []
  end

  private

  def create_table(users)
    table = Terminal::Table.new(headings: ['Rating', 'Name', 'Difficulty', 'Attempts Total',
                                           'Attempts Used', 'Hints Total', 'Hints Used'])
    rate = 1

    users.each do |user|
      table.add_row([rate, user.name, DIFFICULTY.keys[user.difficulty],
                     user.attempts_total, user.attempts_used, user.hints_used, user.hints_total])
      rate += 1
    end
    table
  end
end
