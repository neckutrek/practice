> A const qualifier applies to whatever is immediately to its left. If there is nothing to its left then it applies to whatever is immediately to its right.

# C++11
- **Move semantics**

*move semantics* = swap resource pointers (handles) between x and the temporary, and then let the temporary's destructor destruct x's original resource  
forward = 

  > Rvalue references allow a function to branch at compile time (via overload resolution) on the condition "Am I being called on an lvalue or an rvalue?"
  
  > Things that are declared as rvalue reference can be lvalues or rvalues. The distinguishing criterion is: if it has a name, then it is an lvalue. Otherwise, it is an rvalue.

    void f(int&& a); // rvalue reference
    template<typename T> void f(T&& a); // forwarding/universal reference
      a universal reference will bind to anything, it will accept anything and preserve its constness
    void f(auto&& a); // 

    std::move()
    std::forward<T>()


- **Unified initialization**
- **auto and decltype**

By using `auto&& var = <initializer>` you are saying: **I will accept any initializer regardless of whether it is an lvalue or rvalue expression and I will preserve its constness**.

    auto         => will copy the vector, but we wanted a reference  
    auto&        => will only bind to modifiable lvalues  
    const auto&  => will bind to anything but make it const, giving us const_iterator  
    const auto&& => will bind only to rvalues  

- **lambdas**
- **multithreading**
- **regex**
- **smart pointers**
- **hash tables**
- **std::array**
