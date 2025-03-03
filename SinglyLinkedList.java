class SinglyLinkedList {
    Node head, tail;
    int size = 0;

    public void addToHead(int item) {
        Node newNode = new Node(item);
        if (head == null) {
            head = tail = newNode;
        } else {
            newNode.next = head;
            head = newNode;
        }
        size++;
    }

    public void addToTail(int item) {
        Node newNode = new Node(item);
        if (tail == null) {
            head = tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }
        size++;
    }

    public void removeHead() {
        if (head != null) {
            head = head.next;
            if (head == null) {
                tail = null;
            }
            size--;
        }
    }

    public void removeFromTail() {

        if (head == tail) {
            head = tail = null;
        } else {
            Node current = head;
            while (current.next != tail) {
                current = current.next;
            }
            current.next = null;
            tail = current;
        }
        size--;
    }

    public void printForward() {
        Node current = head;
        while (current != null) {
            System.out.print(current.item + " ");
            current = current.next;
        }
        System.out.println();
    }

    public void printFirstElement() {
        if (head == null) {
            System.out.println("List is empty!");
        } else {
            System.out.println(head.item);
        }
    }

    public void printLastElement(){
        if (tail == null) {
            System.out.println("List is empty!");
        } else {
            System.out.println(tail.item);
        }
    }
}