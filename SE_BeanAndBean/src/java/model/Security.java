package model;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

public class Security {
    private byte[] key = {0x4B, 0x2F, 0x6D, 0x5C, 0x5F, 0x36, 0x25, 0x50, 
                                0x30, 0x4C, 0x6C, 0x40, 0x51, 0x6F, 0x43, 0x74};
    
    public String encrypt(String strToEncrypt){
        String encryptedStr = null;
        
        try{
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            encryptedStr = Base64.encodeBase64String(cipher.doFinal(strToEncrypt.getBytes()));
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return encryptedStr;
    }
    
    public String decrypt(String strToDecrypt){
        String decryptedStr = null;
        
        try{
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            decryptedStr = new String(cipher.doFinal(Base64.decodeBase64(strToDecrypt)));
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return decryptedStr;
    }
}
