# C++11
- **Move semantics**

move = transfer ownership of data  
forward = 

    void f(int&& a); // rvalue reference
    template<typename T> void f(T&& a); // forwarding/universal reference
      a universal reference will bind to anything, it will accept anything and preserve its constness
    void f(auto&& a); // 

    std::move()
    std::forward()


- **Unified initialization**
- **auto and decltype**

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
