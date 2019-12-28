#ifndef __NECKU_ARRAY_H__
#define __NECKU_ARRAY_H__

template<typename T, size_t SIZE>
class Array
{
public:

    inline size_t   size() { return SIZE; }

    T&              operator[](size_t i);

private:
    T               m_data[SIZE];

};

template<typename T, size_t SIZE>
T& Array<T, SIZE>::operator[](size_t i)
{
    assert( i >= 0 );
    assert( i < SIZE );
    return m_data[i];
}


#endif