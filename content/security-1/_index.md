+++
title = "Security 1"
type = "chapter"
weight = 220
+++

## Competency and Learning Objectives

### Competency:

Security Best Practices

### Learning Objectives:

- I can explain and use symmetric and asymmetric envryption in a java application

## Introduction

The foundation of security in software development is the ability to protect data. This is done through encryption.
In this lesson, we will learn about symmetric and asymmetric encryption and how to use them in a Java application.

## Symmetric Encryption

When most people think of encryption, as it's often portrayed in movies and TV shows, they are thinking of symmetric
encryption. Symmetric encryption is a method of encryption where a secret "key" is used to encrypt some piece of data.
This same key is then used to decrypt the data. The key is a secret that must be kept secure, as anyone who has the key
can decrypt the data.

In many action movies, you'll usually see the key portrayed as a password that the hero must discover in order to
decrypt the data. In reality, the key is usually a long string of random characters that is generated by the encryption
algorithm and is stored in a file in a secure location.

So while many people think of an encryption key as looking like this:

```sW0rdF1sh```

A key generally looks more like this:

`B374A26A71490437AA024E4FADD5B497FDFF1A8EA6FF12F6FB65AF2720B59CCF`

Encryption uses this key to perform some mathematical operations with the values in the key and the data to get a result
that is easy to reverse if we have they key, but nearly impossible to reverse if we don't.  There are many different
algorithms that can be used to encrypt data, but they all work in a similar way.  The details of these algorithms are
beyond the scope of this lesson, but it is important to understand that the key is the most important part of the 
encryption process.  The algorithm used to perform the encryption is not generally a secret and is generally well known.

So, if you imagine that our secret spy team all sends messages using an encryption algorithm called AES-256, and all
of our members know that the encyption key is `B374A26A71490437AA024E4FADD5B497FDFF1A8EA6FF12F6FB65AF2720B59CCF`,
then we can all send messages to each other and know that only the people with the key can read them.  We just need
to make sure that no hackers get their hands on our secret key.

### Initialization Vector

One problem with symmetric encryption is that if the same input is encrypted with the same key, the result will always
be the same.  This can be a problem if the same message is sent multiple times.

Back to our spy team example. Suppose we send a message one day that says "meet at the corner of 5th and Main at
3:00pm".  The encrypted message is intercepted by a hacker.  Thankfully since we used encryption and have kept our
key a secret, the hacker can not decrypt the message.  She just sees a bunch of random characters.  However, after
seeing the message, the hacker follows us and sees us meet at the corner of 5th and Main at 3:00pm.

The next day, we send the same message again.  The hacker sees the message and sees that while it is encrypted and
unreadable to her, it is identical to the message she saw us send the day before.  She can now be sure that the message
means "meet at the corner of 5th and Main at 3:00pm".

After this happens, we meet to come up with a plan to prevent this from happening again.  To fix this, we decide to
put a random number at the begining of each message before we encrypt it.  This random number will be used with our
original key to encrypt the message.  That random number will cause the entire message to be encrypted differently
each time it is sent.  If the hacker intercepts the message, she will be unable to determine if the message is the
same as a previous message.

This random number is called an "initialization vector" or IV. An IV is a random value that is generated and sent along
with the encrypted data to ensure that the same input will produce entirely different results each time it is encrypted
depending on the IV.  The IV is not a secret and is generally sent along with the encrypted data.

To decrypt the data, the recipient must use the IV that was used to encrypt the data along with the key.  For this
reason, the IV is generally sent along with the encrypted data.

### Java Example

Here is an example of how to encrypt and decrypt data in java.  At this point, you should be able to read and
understand the code below.  If you have any questions, please ask.

```java
import java.security.SecureRandom;
import java.util.Scanner;
 
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.xml.bind.DatatypeConverter;

public class SymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        // Create a secure random number generator
        // This will be used to generate the key and later IVs
        SecureRandom random = new SecureRandom();

        // Create an encryption key
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(256, random);
        SecretKey secretKey = keyGenerator.generateKey();

        while (true) {
            // Get the message to encrypt
            Scanner scanner = new Scanner(System.in);
            System.out.print("Enter a message to encrypt (type "quit" to quit): ");
            String message = scanner.nextLine();

            if (message.equals("quit")) {
                break;
            }

            // Generate an initialization vector
            byte[] iv = new byte[16];
            random.nextBytes(iv);
            System.out.println("IV: " + DatatypeConverter.printHexBinary(iv));

            // Encrypt the message
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, new IvParameterSpec(iv));
            byte[] encrypted = cipher.doFinal(message.getBytes());

            // Print the encrypted message and IV
            System.out.println("Encrypted message: " + DatatypeConverter.printHexBinary(encrypted));

            // Decrypt the message
            cipher.init(Cipher.DECRYPT_MODE, secretKey, new IvParameterSpec(iv));
            byte[] decrypted = cipher.doFinal(encrypted);

            // Print the decrypted message
            System.out.println("Decrypted message: " + new String(decrypted));
        }
    }
}
```

### Check For Understanding

1. **Question:**  What is the secret part of symmetric encryption?
    - **Answer:**  The encryption key
2. **Question:**  What is needed to decrypt data that has been encrypted with symmetric encryption?
    - **Answer:**  The encryption key and the initialization vector if one was used
3. **Question:**  What is the purpose of the initialization vector?
    - **Answer:**  To ensure that the same input will produce different results each time it is encrypted
4. **Question:**  What is the purpose of the SecureRandom object?
    - **Answer:**  To generate random numbers that are used in the encryption process
5. **Question:**  What is the purpose of the KeyGenerator object?
    - **Answer:**  To generate the encryption key

## Asymmetric Encryption

Unfortunately, symmetric encryption has a major flaw.  If the key is lost or stolen, all of the data that was
encrypted with that key is now vulnerable.  This is a major problem if the data is stored for a long time or if the
data is sent to many different people.

To solve this problem, asymmetric encryption was developed.  Asymmetric encryption uses two keys, a public key and a
private key.  The public key is used to encrypt data, and the private key is used to decrypt data.  The public key can
be shared with anyone, but the private key must be kept secret.

Our spy team decides to use asymmetric encryption to send messages to each other.  Each member of the team generates
a public/private key pair.  They then share their public key with the other members of the team.  When a member wants
to send a message to another member, they use the recipient's public key to encrypt the message.  The recipient then
uses their own private key to decrypt the message.

For example, let's say that Alice wants to send the message "meet at the corner of 5th and Main at 3:00pm" to Bob.

1. Alice gets Bob's public key.
2. Alice encrypts the message with Bob's public key.
3. Alice sends the encrypted message to Bob.
4. Bob decrypts the message with his private key.
5. Bob reads the message.

In this scenario, the public keys are not secret and can be shared with anyone.  We do not even care if the hacker
gets ahold of our public keys.  The reason is that the public key can only be used to encrypt data for one of our
team members to read. None of the public keys can be used to decrypt any of the messages.

We can generate a public/private key pair using the `ssh-keygen` command at the terminal.  This command will generate
a public key and a private key.  The public key can be shared with anyone, but the private key must be kept secret.

Let's go to our home directory and generate a key pair.

```bash
cd ~
ssh-keygen -t rsa -b 2048 -f mykey
```

This command will generate two files, `mykey` and `mykey.pub`.  The `mykey` file is the private key and should be kept
secret.  The `mykey.pub` file is the public key and can be shared with anyone.

Let's create a simple java program that allows us to either encrypt a message for someone else on our team, or to
decrypt a message that was encrypted for us.

```java
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.util.Scanner;
import javax.crypto.Cipher;
import javax.xml.bind.DatatypeConverter;

public class AsymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);

        while(true) {
            System.out.println("SECRET SPY TEAM COMMUNICATION SYSTEM");
            System.out.println("======================================");
            System.out.println("1. Encrypt a message");
            System.out.println("2. Decrypt a message");
            System.out.println("3. Quit");

            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();

            if (choice == 1) {
                encryptMessage();
            } else if (choice == 2) {
                decryptMessage();
            } else if (choice == 3) {
                break;
            } else {
                System.out.println("Invalid choice");
            }
        }
    }

    public static void encryptMessage() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter path to target user's public key file: ");
        String publicKeyPath = scanner.nextLine();
        System.out.println("Enter message to encrypt: ");
        String message = scanner.nextLine();

        try {
            // Read the public key
            PublicKey publicKey = readPublicKey(publicKeyPath);

            // Encrypt the message
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            byte[] encrypted = cipher.doFinal(message.getBytes());

            // Print the encrypted message
            System.out.println("Encrypted message:");
            System.out.println(DatatypeConverter.printHexBinary(encrypted));
        } catch (Exception e) {
            System.out.println("Error encrypting message: " + e.getMessage());
        }
    }

    public static void decryptMessage() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter path to your private key file: ");
        String privateKeyPath = scanner.nextLine();
        System.out.println("Enter encrypted message: ");
        String encryptedMessage = scanner.nextLine();

        try {
            // Read the private key
            PrivateKey privateKey = readPrivateKey(privateKeyPath);

            // Decrypt the message
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            byte[] decrypted = cipher.doFinal(DatatypeConverter.parseHexBinary(encryptedMessage));

            // Print the decrypted message
            System.out.println("Decrypted message:");
            System.out.println(new String(decrypted));
        } catch (Exception e) {
            System.out.println("Error decrypting message: " + e.getMessage());
        }
    }
}
```

### Check For Understanding

1. **Question:** Why might we want to use asymmetric encryption instead of symmetric encryption?
    - **Answer:** So that we do not have to share a secret key with everyone we want to communicate with.
1. **Question:** What is the secret part of asymmetric encryption?
    - **Answer:** The private key
2. **Question:** What is needed to decrypt data that has been encrypted with asymmetric encryption?
    - **Answer:** The private key
3. **Question:** What is the purpose of the public key?
    - **Answer:** To encrypt data
4. **Question:** What is the purpose of the private key?
    - **Answer:** To decrypt data

## Reflection Task

- Prompt: Consider a scenario (not user authentication) where you might want to use encryption in a Java application. 
What kind of encryption would you use and why?
- Expected Outcomes: 
    - **Green**: Student can explain a scenario where encryption would be useful and can explain why they would use a
    particular type of encryption.
    - **Yellow**: Student can explain a scenario where encryption might be useful but can not explain why they would use
    a particular type of encryption.
    - **Red**: Student can not explain a scenario where encryption would be useful.

## Sharing Task

- Prompt:  Generate keys and use the spy team program to send messages to each other.
1. Form groups.
2. Have each member of your group generate a public/private key pair using the `ssh-keygen` command as explained above.
3. Have each member share their public key with the other members of the group so that everyone has everyone else's
public key and their own private key.
4. Copy the spy team program that we wrote in this lesson into intellij and run it. 
5. Choose someone in the group to create a message for another member of the group.  This user should run the program
and encrypt the message using the recipient's public key.
6. The recipient should then run the program and decrypt the message using their private key.
7. Send the message to another person in the group and have them decrypt it. They should not be unable to decrypt the
message as it was encrypted with the recipient's public key.
8. Repeat steps 5-7 until everyone has had a chance to send and receive a message.

- Format (individual, pair programming, presentation, group discussion, etc.):  Group
- Tools: `ssh-keygen`, Java, Intellij

## Conclusion

In this lesson, we learned about symmetric and asymmetric encryption.  We learned that symmetric encryption uses a
secret key to encrypt and decrypt data, while asymmetric encryption uses a public key to encrypt data and a private key
to decrypt data.  We also learned how to generate keys and use them to encrypt and decrypt data in a Java application.

Encryption is an important part of a fullstack developer's toolkit. Having a good understanding of encryption will help
you to secure your applications and protect your users' data.

