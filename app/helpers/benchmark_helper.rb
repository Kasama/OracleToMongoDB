module BenchmarkHelper
  def random_string(length)
    (36**(length-1) + rand(36**length)).to_s(36)
  end

  def insert_into(document_name, n)

  end
end
