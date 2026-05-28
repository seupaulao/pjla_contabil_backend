import * as fs from "fs";
import { SignedXml } from "xml-crypto";
class AssinaturaService {

   async assinar(xml: string) {

      const cert =
        fs.readFileSync("cert.pem");

      const key =
        fs.readFileSync("key.pem");

      const sig = new SignedXml({
         privateKey: key,
         publicCert: cert
      });

      sig.addReference({
         xpath: "//*[local-name(.)='infNFe']",
         digestAlgorithm:
           "http://www.w3.org/2001/04/xmlenc#sha256",
         transforms: [
           "http://www.w3.org/2000/09/xmldsig#enveloped-signature",
           "http://www.w3.org/TR/2001/REC-xml-c14n-20010315"
         ]
      });

      sig.computeSignature(xml);

      return sig.getSignedXml();
   }
}

export { AssinaturaService };