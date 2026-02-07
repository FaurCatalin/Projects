package siaps.group;

import javax.persistence.*;
import lombok.*;

@NoArgsConstructor
@RequiredArgsConstructor
@Getter @Setter @ToString
@Entity
@Table(name = "masini")
public class Masina {

    @Id
    @NonNull
    @Column(name = "nr_inmatriculare", length = 20)
    private String nrInmatriculare;

    private Integer id_utilizator;

    @NonNull private String marca;
    @NonNull private String model;

    private String culoare;
    private Integer anulFabricatiei;
    private Integer capacitateaCilindrica;
    private String tipulDeCombustibil;
    private Integer puterea;
    private Integer cuplul;
    private Integer volumulPortbagajului;
    private Double pret;
}
