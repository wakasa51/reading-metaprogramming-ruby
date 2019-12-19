# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること

class A1
  define_method('//') do
    '//'
  end
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと

class A2
  def initialize(args)
    args.each do |arg|
      name = "hoge_#{arg}"
      A2.define_hoge(name) unless respond_to?(name)
    end
  end

  def self.define_hoge(name)
    define_method(name) do |num|
      if num.nil?
        dev_team
      else
        name * num
      end
    end
  end

  def dev_team
    'SmartHR Dev Team'
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること

module OriginalAccessor
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def my_attr_accessor(*args)
      args.each do |arg|
        define_attr(arg)
      end
    end

    def define_attr(name)
      define_method(name) do
        instance_variable_get(:"@#{name}")
      end

      define_method("#{name}=") do |value|
        if value.kind_of?(::TrueClass) || value.kind_of?(::FalseClass) && !self.respond_to?("#{name}?")
          self.class.define_method("#{name}?") do
            instance_variable_get(:"@#{name}")
          end
        else
          if self.respond_to?("#{name}?")
            self.class.remove_method("#{name}?")
          end
        end
        instance_variable_set(:"@#{name}", value)
      end
    end
  end
end
