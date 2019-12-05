# 次に挙げるクラスのいかなるインスタンスからも、hogeメソッドが呼び出せる
# それらのhogeメソッドは、全て"hoge"という文字列を返す
# - String
# - Integer
# - Number
# - Class
# - Hash
# - TrueClass
module DefineHoge
  def hoge
    'hoge'
  end
end

class String
  include DefineHoge
end

class Integer
  include DefineHoge
end

class Numeric
  include DefineHoge
end

class Class
  include DefineHoge
end

class Hash
  include DefineHoge
end

class TrueClass
  include DefineHoge
end
