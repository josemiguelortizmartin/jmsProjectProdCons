package prueba.jms;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Stateless
public class ConsumidorSincrono {

	final static Logger logger = LogManager.getLogger(ConsumidorSincrono.class);
	
	@Resource(mappedName = "java:/ConnectionFactory")
    private ConnectionFactory connectionFactory;
	@Resource(mappedName = "java:/jms/QueuePrueba")
	private Queue queue;

    public void recibeMensajeSincronoCola() throws JMSException {

        Connection connection = null;
        Session session = null;

        MessageConsumer consumer = null;
        TextMessage message = null;
        boolean esTransaccional = false;

        try {
            logger.info("Comienzo sincrono");
            connection = connectionFactory.createConnection();
            // Recordar llamar a start() para permitir la recepción de mensajes
            connection.start();
            // Creamos una sesion sin transaccionalidad y con envio de acuse automatico
            session = connection.createSession(esTransaccional, Session.AUTO_ACKNOWLEDGE);
            // Creamos el consumidor a partir de una cola
            consumer = session.createConsumer(queue);
            // Recibimos un mensaje de texto
            message = (TextMessage) consumer.receive();

            // Sacamos el mensaje por consola
            logger.info("Recibido sincrono [" + message.getText() + "]");
            logger.info("Fin sincrono");
        } finally {
            // Cerramos los recursos
            consumer.close();
            session.close();
            connection.close();
        }
    }
}
