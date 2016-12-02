class Fifteen
  def initialize(numbers = nil)
    numbers ||= ((1..15).to_a + ["_"]).sort_by { rand }
    @field = []
    while numbers.any?
      @field << numbers.slice!(0, 4)
    end
  end

  def [](row)
    @field[row]
  end

  def inspect
    @field.map { |row| row.map { |val| val.to_s.rjust(2, " ") }.join(" ") }.join("\n")
  end

  def slide!(row, col)
    e_row, e_col = empty_pos
    if row == e_row
      new_fif = Fifteen.new(@field.flatten)
      if e_col < col
        (e_col...col).each { |i| new_fif[row][i] = new_fif[row][i+1] }
        new_fif[row][col] = '_'
      elsif e_col > col
        (e_col.downto(col)).each { |i| new_fif[row][i] = new_fif[row][i-1] }
        new_fif[row][col] = '_'
      end
      new_fif
    elsif e_col == col
      new_fif = Fifteen.new(@field.flatten)
      if e_row < row
        (e_row...row).each { |i| new_fif[i][col] = new_fif[i+1][col] }
        new_fif[row][col] = '_'
      elsif e_row > row
        (e_row.downto(row)).each { |i| new_fif[i][col] = new_fif[i-1][col] }
        new_fif[row][col] = '_'
      end
      new_fif
    else
      self
    end
  end

  def empty_pos
    [0, 1, 2, 3].permutation(2).detect { |row, col| self[row][col] == '_' }
  end

  def set_empty(row, col)
    self[row][col] = '_'
  end
end
