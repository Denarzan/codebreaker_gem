module ShowContent
  def show_stats(file)
    data = YAML.load_file(file) || []
    data.sort_by(&:hints_used).sort_by(&:attempts_used).sort_by { |game| -game.difficulty }
  rescue Errno::ENOENT
    []
  end
end
