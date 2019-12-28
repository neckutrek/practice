#ifndef __NECKU_LIST_H__
#define __NECKU_LIST_H__

#include <memory>

template<typename T>
class List
{
public:

    size_t      size() noexcept { return m_size; }

    void        push_back(T& val)
                {
                    m_tail->m_previous = std::make_unique<T>(new T(val));
                }

    void        push_front(T& val)
                {
                    m_head->m_next = std::make_unique<T>(new T(val));
                }

    T&          operator[](size_t i)
                {
                    assert( i >= 0 );
                    assert( i < m_size );
                    
                    for (int j=0; j<i; ++j)
                    {
                        
                    }
                }

private:

    class Node
    {
    public:
        std::unique_ptr<Node>       m_previous;
        std::unique_ptr<Node>       m_next;
        T                           m_data;
    }

    std::unique_ptr<Node>       m_head;
    std::unique_ptr<Node>       m_tail;
    size_t                      m_size;

};

#endif
