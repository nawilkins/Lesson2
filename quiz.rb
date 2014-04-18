#1.)
#@a = 2
# =>  is an instance variable for a class
# user = User.new
# => is an object user of class User
# user.name
# => is a getter method call of 'name' on object instance user
# user.name = "Joe"
# => is a setter method call on instance variable 'name' for object instance 'user', setting 'name' to 'Joe'

#2.) A class mixins a module by using the keyword 'include [module_name]' into the class defintion. Functionally, the module methods are given to the class definition as if they were natively declared.

#3.) Instance variables are specific to the object instance of the class, and can be different from object instance to object instance. However, class variables pertain to the class itself, and not the individual instance

#4.) attr_accessor automatically adds the getter and setter methods for instance variables you want to be able to get and set, without having to write the methods by hand

#5.) The class Dog (not an instance of it) is performing an action called some_method. All instances of Dog would potentially be affected

#6.) Subclassing allows for only a single parent-sibling relationship (they can be daisy-chained/linked), whereas modules can simulate multiple inheritance and provide more fine-grained control of class behaviors

#7.)
	# def initialize(n)
	# 	@name = n
	# end

#8.) You can call instance methods of the same class from other instance methods of that class

#9.) Not sure...