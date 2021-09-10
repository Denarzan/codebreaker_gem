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
  rescue Errno::ENOENT
    []
  end
end
