package br.com.dispositivosmoveis.avaliacao3.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Component;

@Component
public class StudentDao {

    @PersistenceContext
    private EntityManager entityManager;

}
