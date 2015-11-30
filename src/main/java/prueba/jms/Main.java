package prueba.jms;

import java.util.Date;

import javax.ejb.EJB;
import javax.jms.JMSException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

//import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
// @EnableAutoConfiguration
public class Main {
	final static Logger logger = LogManager.getLogger(Main.class);

	@EJB(mappedName = "java:app/jmsProject/Productor")
	Productor prod;

	@EJB(mappedName = "java:app/jmsProject/ConsumidorAsincrono")
	ConsumidorAsincrono consAsin;

	@EJB(mappedName = "java:app/jmsProject/ConsumidorSincrono")
	ConsumidorSincrono consSin;

	String MensajeEnviadoPattern = "Mensaje %s";

	@RequestMapping("/producir")
	public String producirMensajeJMS() throws JMSException {
		logger.info("Se va a crear un mensaje JMS.");

		Date d = new Date();

		prod.enviarMensaje(String.format(MensajeEnviadoPattern, d.toString()));
		return "Enviado mensaje JMS (" + d.toString() + ")";
	}

	@RequestMapping("/consumirAsincrono")
	public String consumirAsincronoMensajeJMS() throws JMSException {
		logger.info("Se va a consumir (asincrono) un mensaje JMS.");

		consAsin.recibeMensajeAsincronoCola();
		return "Consumiendo mensajes asincronamente";
	}

	@RequestMapping("/consumirSincrono")
	public String consumirSincronoMensajeJMS() throws JMSException {
		logger.info("Se va a consumir (Sincrono) un mensaje JMS.");

		consSin.recibeMensajeSincronoCola();
		return "Consumiendo mensajes Sincronamente";
	}

}
