package prueba.jms;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class JMSListener implements MessageListener{

	final static Logger logger = LogManager.getLogger(JMSListener.class);

	
	public void onMessage(Message message) {
		TextMessage msg = null;
		
        try {
			if (message instanceof TextMessage) {
                msg = (TextMessage) message;
                logger.info("Recibido asincrono [" + msg.getText() + "]");
            } else {
            	logger.info("El mensaje no es de tipo texto");
            }
        } catch (JMSException e) {
        	logger.error("JMSException en onMessage(): ", e);
        } catch (Throwable t) {
        	logger.error("Exception en onMessage():" + t);
        }		
	}

}
