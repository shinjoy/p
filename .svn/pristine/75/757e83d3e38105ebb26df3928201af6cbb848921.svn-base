package ib.basic.web;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class TwoWayCryptographic {
	
	private static final String _cipherAlgorithm = "DES";
	
	public static String encryptText(String text, String key){
		String encrypted;
      try{
            SecretKeySpec ks = new SecretKeySpec(generateKey(key), _cipherAlgorithm );
            Cipher cipher = Cipher. getInstance(_cipherAlgorithm);
            cipher.init(Cipher. ENCRYPT_MODE, ks);
             byte[] encryptedBytes = cipher.doFinal(text.getBytes());
            encrypted = new String(Base64Coder.encode(encryptedBytes));
      }catch (Exception e){
            e.printStackTrace();
            encrypted = text;
      }
      return encrypted;
    }
	
	public static String decryptText(String text, String key) {
      String decrypted;

      try{
            SecretKeySpec ks = new SecretKeySpec(generateKey(key), _cipherAlgorithm );
            Cipher cipher = Cipher. getInstance(_cipherAlgorithm);
            cipher.init(Cipher. DECRYPT_MODE, ks);
             byte[] decryptedBytes = cipher.doFinal(Base64Coder.decode(text));
            decrypted = new String(decryptedBytes);
      }catch (Exception e){
            decrypted = text;
      }
      return decrypted;
    }
    
	public static byte[] generateKey(String key){
      byte[] desKey = new byte [8];
      byte[] bkey = key.getBytes();

      if (bkey. length < desKey.length ) {
            System. arraycopy(bkey, 0, desKey, 0, bkey.length);
             for (int i = bkey.length; i < desKey. length; i++)
                  desKey[i] = 0;
      }else System. arraycopy(bkey, 0, desKey, 0, desKey.length);

      return desKey;
    }
}
