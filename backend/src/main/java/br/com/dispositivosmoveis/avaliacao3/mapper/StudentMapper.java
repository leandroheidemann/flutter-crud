package br.com.dispositivosmoveis.avaliacao3.mapper;

import br.com.dispositivosmoveis.avaliacao3.entity.Student;
import br.com.dispositivosmoveis.avaliacao3.model.StudentDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Mappings;

@Mapper(componentModel = "spring")
public interface StudentMapper {

    @Mappings({
            @Mapping(target = "id", source = "id"),
            @Mapping(target = "name", source = "name"),
            @Mapping(target = "email", source = "email")
    })
    StudentDto toDto(Student student);
    @Mappings({
            @Mapping(target = "id", source = "id"),
            @Mapping(target = "name", source = "name"),
            @Mapping(target = "email", source = "email")
    })
    Student toEntity(StudentDto studentDto);
    @Mappings({
            @Mapping(target = "id", source = "id"),
            @Mapping(target = "name", source = "name"),
            @Mapping(target = "email", source = "email")
    })
    Student toEntity(StudentDto dto, @MappingTarget Student entity);

}
