import java.util.Scanner;

public class MidtermActivity1 {
    public static void main(String[] args) {
        SinglyLinkedList list = new SinglyLinkedList();
        Scanner scanner = new Scanner(System.in);
        int choice, item;

        do {
            System.out.println("\n==== Singly Linked List Menu ====");
            System.out.println("1. Add to Head");
            System.out.println("2. Add to Tail");
            System.out.println("3. Remove from Head");
            System.out.println("4. Remove from Tail");
            System.out.println("5. Print List (Forward)");
            System.out.println("6. Print First Element");
            System.out.println("7. Print Last Element");
            System.out.println("8. Exit");
            System.out.print("Enter your choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter value to add at head: ");
                    item = scanner.nextInt();
                    list.addToHead(item);
                    break;
                case 2:
                    System.out.print("Enter value to add at tail: ");
                    item = scanner.nextInt();
                    list.addToTail(item);
                    break;
                case 3:
                    list.removeHead();
                    System.out.println("Head removed.");
                    break;
                case 4:
                    list.removeFromTail();
                    System.out.println("Tail removed.");
                    break;
                case 5:
                    System.out.print("List (Forward): ");
                    list.printForward();
                    break;
                case 6:
                    list.printFirstElement();
                    break;
                case 7:
                    list.printLastElement();
                    break;
                case 8:
                    System.out.println("Exiting program...");
                    break;
                default:
                    System.out.println("Invalid choice! Please enter a number between 1-8.");
            }
        } while (choice != 8);

        scanner.close();
    }
}
