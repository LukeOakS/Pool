import Fastify from "fastify";
import cors from "@fastify/cors";
import { poolRoutes } from "./routes/pool";
import { gameRoutes } from "./routes/game";
import { userRoutes } from "./routes/user";
import { guessRoutes } from "./routes/guess";
import { authRoutes } from "./routes/auth";
import fastifyJwt from "@fastify/jwt";



async function bootstrap(){
    const fastify = Fastify({
        logger: true,
    })

    await fastify.register(cors, {
        origin: true
    })

    //Em produção é necessário que seja uma variável de ambiente
    await fastify.register(fastifyJwt, {
        secret: 'NLWCOPA456823971'
    })

    await fastify.register(poolRoutes);
    await fastify.register(gameRoutes);
    await fastify.register(userRoutes);
    await fastify.register(guessRoutes);  
    await fastify.register(authRoutes);  

    
    await fastify.listen({ port: 3333, host: '0.0.0.0' })
}

bootstrap()