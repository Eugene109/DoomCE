#include <cstring>

template <typename Object>
template <typename KeyType>

class map {
  public:
    map() {
        sizeOfMap = 0;
        max_capacity = 4;
        objects = new Object[4];
    }

    Object &operator[](KeyType key) { return objects[keys[key]]; }

    const Object &operator[](KeyType key) const { return objects[keys[key]]; }

    void push_back(const Object &obj) {
        if (sizeOfVector == max_capacity) {
            reserve(2 * max_capacity + 1);
        }
        objects[sizeOfVector++] = obj;
    }
    void reserve(unsigned newCapacity) {
        if (newCapacity < sizeOfVector) {
            return;
        }
        Object *newArray = new Object[newCapacity];
        memcpy(newArray, objects, sizeOfVector);
        delete[] objects;
        objects = newArray;
    }
    int size() { return sizeOfVector; }

  private:
    unsigned sizeOfVector;
    unsigned max_capacity;
    Object *objects;
};