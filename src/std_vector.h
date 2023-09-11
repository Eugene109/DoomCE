#include <cstring>

template <typename Object>

class vector {
  public:
    vector() {
        sizeOfVector = 0;
        max_capacity = 4;
        objects = new Object[4];
    }
    vector(unsigned size, Object element) {
        reserve(2 * size + 1);
        for (sizeOfVector = 0; sizeOfVector < size; sizeOfVector++) {
            objects[sizeOfVector] = element;
        }
    }

    Object &operator[](unsigned index) { return objects[index]; }

    const Object &operator[](unsigned index) const { return objects[index]; }

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

  private:
    unsigned sizeOfVector;
    unsigned max_capacity;
    Object *objects;
};