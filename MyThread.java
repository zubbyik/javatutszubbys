public class MyThread {

    public static String getChange(){
        return "I get changed";
    }

    
    public static void main(String[] args) {
        NewRun newRun = new NewRun();

    Runnable mYrun = ()-> System.out.println("Hello runnable");
    Runnable loRun = new Runnable() {
        public void run() {
            System.out.println("implementing his ");
        };
    };
    Thread myThread = new Thread(mYrun);
    Thread myThread1 = new Thread(newRun);
    Thread myThread2 = new Thread(loRun);
    // myThread.setName("First");
    // System.out.println(myThread.getName());
    // System.out.println(myThread1.getName());
    // System.out.println(myThread2.getName());
    // System.out.println("Hello");
    // System.out.println("Hello 2");
    // System.out.println(myThread.toString());
    myThread.run();
    myThread1.run();
    myThread2.start();
    myThread.
}


}


class NewRun implements Runnable{
    @Override
    public void run() {
        System.out.println("From the inner run");
    }
}