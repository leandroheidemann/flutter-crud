package br.com.dispositivosmoveis.avaliacao3.service;

import br.com.dispositivosmoveis.avaliacao3.dao.StudentDao;
import br.com.dispositivosmoveis.avaliacao3.mapper.StudentMapper;
import br.com.dispositivosmoveis.avaliacao3.model.StudentDto;
import br.com.dispositivosmoveis.avaliacao3.repository.StudentRepository;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    private final StudentRepository repository;
    private final StudentDao dao;
    private final StudentMapper mapper;

    @Autowired
    public StudentService(StudentRepository repository, StudentDao dao, StudentMapper mapper) {
        this.repository = repository;
        this.dao = dao;
        this.mapper = mapper;
    }

    public StudentDto create(final StudentDto dto) {
        return mapper.toDto(repository.save(mapper.toEntity(dto)));
    }

    public List<StudentDto> findAll() {
        return repository.findAll()
                .stream()
                .map(mapper::toDto)
                .toList();
    }

    public StudentDto findById(final UUID id) {
        return repository.findById(id)
                .map(mapper::toDto)
                .orElseThrow();
    }

    public StudentDto update(final UUID id, final StudentDto dto) {
        var student = repository.findById(id)
                .orElseThrow();

        student = mapper.toEntity(dto, student);

        return mapper.toDto(repository.save(student));
    }

    public void delete(final UUID id) {
        repository.deleteById(id);
    }
}
