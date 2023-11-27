package br.com.dispositivosmoveis.avaliacao3.repository;

import br.com.dispositivosmoveis.avaliacao3.entity.Student;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, UUID> {
}
