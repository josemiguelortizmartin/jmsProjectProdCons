package prueba.jms;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Stateless
public class Productor {
	
	final static Logger logger = LogManager.getLogger(Productor.class);
	
	
	@Resource(mappedName = "java:/ConnectionFactory")
    private ConnectionFactory connectionFactory;
	@Resource(mappedName = "java:/jms/QueuePrueba")
	private Queue queue;
	

	public void enviarMensaje(String mensaje) throws JMSException {
		
		Connection connection = null;
		Session session = null;
		MessageProducer productorJMS = null;
		
		Boolean esTransaccional = Boolean.FALSE;
        Message message = null;
        
		try{
			connection = connectionFactory.createConnection();
            // Recordar llamar a start() para permitir el envio de mensajes
            connection.start();
            // Creamos una sesion sin transaccionalidad y con envio de acuse automatico
			session = connection.createSession(esTransaccional, Session.AUTO_ACKNOWLEDGE);
            // Creamos el productor a partir de una cola
			productorJMS = session.createProducer(queue);
            // Creamos un mensaje sencillo de texto
            message = session.createTextMessage(mensaje);
            // Mediante le productor, enviamos el mensaje
            productorJMS.send(message);
			
            logger.info("Mensaje enviado [" + mensaje + "]");
		}catch(JMSException jmsExc){
            logger.error("Error JMS", jmsExc);
        } finally {
            // Cerramos los recursos
            productorJMS.close();
            session.close();
            connection.close();
        }
		
	}
}
